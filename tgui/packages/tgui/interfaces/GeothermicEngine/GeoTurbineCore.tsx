import { useBackend } from 'tgui/backend';
import { Box, Section, ProgressBar, Button, Stack, NoticeBox } from 'tgui-core/components';

interface GeoTurbineCoreData {
  rpm: number;
  stress: number;
  housing_temp: number;
  flow_rate: number;
  filter: number;
  max_rpm: number;
  max_stress: number;
  max_temp: number;
  max_flow: number;
  max_filter: number;
}

export const GeoTurbineCore = () => {
  const { act, data } = useBackend<GeoTurbineCoreData>();

  const { rpm, stress, housing_temp, flow_rate, filter,
          max_rpm, max_stress, max_temp, max_flow, max_filter } = data;

  const adjustSteps = [-10, -5, -1, +1, +5, +10];

  const barColor = (pct: number) => {
    if (pct < 50) return 'good';     // green
    if (pct < 80) return 'average';  // amber
    return 'bad';                    // red
  };

  return (
    <Box>
      <Section title="Turbine Core Control">
        <Stack vertical>
          <Stack.Item>
            <b>RPM:</b> {rpm} / {max_rpm}
            <ProgressBar
              value={(rpm / max_rpm) * 100}
              color={barColor((rpm / max_rpm) * 100)}
            />
          </Stack.Item>

          <Stack.Item>
            <b>Stress:</b> {stress} %
            <ProgressBar
              value={(stress / max_stress) * 100}
              color={barColor((stress / max_stress) * 100)}
            />
            {stress > 80 && (
              <NoticeBox color="bad">
                Warning: Stress levels critical!
              </NoticeBox>
            )}
          </Stack.Item>

          <Stack.Item>
            <b>Housing Temp:</b> {housing_temp} K
            <ProgressBar
              value={(housing_temp / max_temp) * 100}
              color={barColor((housing_temp / max_temp) * 100)}
            />
          </Stack.Item>

          <Stack.Item>
            <b>Flow Rate:</b> {flow_rate} L/s
            <ProgressBar
              value={(flow_rate / max_flow) * 100}
              color={barColor((flow_rate / max_flow) * 100)}
            />
          </Stack.Item>

          <Stack.Item>
            <b>Filter Setting:</b> {filter}
            <ProgressBar
              value={(filter / max_filter) * 100}
              color={barColor((filter / max_filter) * 100)}
            />
            <Box textAlign="center">
              {adjustSteps.map((n) => (
                <Button key={n} onClick={() => act('adjust_filter', { amount: n })}>
                  {n > 0 ? `+${n}` : n}
                </Button>
              ))}
            </Box>
          </Stack.Item>
        </Stack>
      </Section>
    </Box>
  );
};
